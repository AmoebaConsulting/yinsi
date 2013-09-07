module MotionModel
  module RestfulModel

    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval {
        # Store the model's sub-class so we can use it in the module (i.e. User)
        @model_class = base
      }
    end

    module ClassMethods
      attr_reader :model_class

      def observer(&callback)
        observer = App.notification_center.observe('MotionModelDataDidChangeNotification') do |notification|
          if notification.object.is_a?(@model_class)
            callback.call(notification)
          end
        end

        observer
      end

      def http_query(url,&block)
        builder = HttpBuilder.new
        block.call(builder)
        builder.build(url)
      end

      # This will add a record to the store directly from the server w/o adjusting created_at
      # Note that invalid records will not be stored (check the result to see if it's .valid?).
      # Duplicate records will also be ignored, checking against the @primary_key. If a duplicate
      # record sent to this method, it will return nil and not add it to the store. Finally,
      # before_save callbacks will not be issued, but notifications will be sent.
      def create_from_server(args)
        if args[@primary_key]
          existing_records_count = self.where(@primary_key).eq(args[@primary_key]).all.count
          if existing_records_count == 0
            b = self.new(args)
            b.add_to_store
            b.issue_server_sync_notification
            return b
          end
        else
          raise "Cannot sync record from server, missing primary key #{@primary_key}."
        end

        nil # return nil if we didn't actually store it
      end

      def primary_key(key=nil)
        @primary_key = key if key
        @primary_key ||= :id
      end

      def collection_uri(uri=nil)
        @collection_uri = uri if uri
        @collection_uri
      end

      def element_uri(uri=nil)
        @element_uri = uri if uri
        @element_uri
      end

      def restful_errors(errors=nil)
        @restful_errors = errors if errors
        @restful_errors || {}
      end

      # This is the name of the "root node" in JSON responses for this model
      # Usually, this is just the lowercase singular name of the model.
      def root_node
        @model_class.to_s.downcase
      end

    end # End of class methods

    ###############################################################################################
    #                                     Instance Methods
    ###############################################################################################

    def skip_next_sync!
      @skip_next_sync = true
    end

    def skip_next_sync?
      @skip_next_sync || false
    end

    def before_save(record)
      # If we're skipping the next server sync, break out
      # (used for instance when updating a field known to be on the server)
      if skip_next_sync?
        @skip_next_sync = false
        return true
      end

      #If we aren't valid, break out
      return true unless valid?

      if new_record?
        verb = :post
        request_uri = self.class.collection_uri
      elsif dirty?
        verb = :put
        request_uri = self.uri
      else
        return true # If we aren't new or dirty, just break out
      end

      http_query(request_uri) do |q|
        q.verb = verb
        q.data = build_data_for_server
        q.response do |res|
          if res.success?
            if new_record?
              fields = res[self.class.root_node]
              primary_key = self.class.primary_key
              if self.send(primary_key) != fields[primary_key.to_s]
                self.send("#{primary_key.to_s}=".to_s,fields[primary_key.to_s])
                self.skip_next_sync!
                self.save
              end
            end
          else # response was a failure
            self.destroy
          end
        end

        error_messages_for(:save).each do |code, msg|
          q.error(code) do
            App.alert(msg)
          end
        end
      end

      true
    end

    def build_data_for_server
      ignore_cols = [:created_at, :updated_at]
      ignore_cols << :id unless self.class.primary_key == :id

      { self.class.root_node =>
          self.columns.each_with_object({}) do |col, hash|
            hash[col] = self.send(col) unless ignore_cols.include?(col)
          end
      }
    end

    def decode_data_from_server(res)
      #TODO Maybe add some error checking

      # Symbolize the keys
      res[self.class.root_node].each_with_object({}) { |(k,v), memo| memo[k.to_sym] = v }
    end

    def issue_server_sync_notification
      issue_notification(:action => "add")
    end

    def destroy_remote
      if new_record?
        self.destroy
      else
        http_query(self.uri) do |q|
          q.verb = :delete

          q.response do |res|
            self.destroy
          end

          q.error(404) do
            self.destory # Silently ignore 404 errors and just destroy them locally
          end
        end
      end
    end

    def uri
      self.class.element_uri.gsub(/:primary_key/, self.send(self.class.primary_key))
    end

    ################
    # Private Functions
    ################

    private

    # Return the error messages for given operation (:save or :destroy)
    def error_messages_for(operation)
      self.class.restful_errors[operation]
    end

    # Allow http_query to be accessed from the instance too
    def http_query(url, &block)
      self.class.http_query(url, &block)
    end

  end
end