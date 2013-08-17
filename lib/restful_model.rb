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
      # record sent to this method, it will return false and not add it to the store. Finally,
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

      def primary_key
        @primary_key || :id
      end
    end

    ###############################################################################################
    #                                     Instance Methods
    ###############################################################################################

    def before_save(record)
      if new_record?
        # TODO: sync it to the server
      end
      true
    end

    def issue_server_sync_notification
      issue_notification(:action => "add")
    end

    # Allow http_query to be accessed from the instance too
    def http_query(url, &block)
      self.class.http_query(url, &block)
    end

  end
end