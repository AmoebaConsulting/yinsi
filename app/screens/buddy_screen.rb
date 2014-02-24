class BuddyScreen < PM::TableScreen
  include YinsiHelpers
  #include Teacup::TableViewDelegate

  title "CONTACTS"
  #title "Buddies"
  indexable
  #searchable placeholder: "Search for a buddy..."
  refreshable callback: :on_refresh,
              pull_message: "Pull to refresh",
              refreshing: "Refreshing data…",
              updated_format: "Last updated at %s",
              updated_time_format: "%l:%M %p"

  stylesheet :buddy

  def on_init
    #set_tab_icon(:group, "contacts")
    set_tab_icon(:group, "Buddies")
    #set_tab_bar_item icon: { selected: icon, unselected: "mypng.png".uiimage }, title: "Buddies"
    self.view.stylename = :root

    set_nav_bar_button :right, system_item: :add, action: :add_buddy
    set_nav_bar_button :back, title: '<', style: :plain, action: :back

    # Style the navigation bar (& buttons in it)
    self.navigationController.navigationBar.configureFlatNavigationBarWithColor(stylesheet_var(:grey_dark))
    UIBarButtonItem.configureFlatButtonsWithColor stylesheet_var(:blackish),
      highlightedColor: stylesheet_var(:grey_dark),
      cornerRadius: 3

    table_view.contentOffset = CGPointMake(0, 44)
  end

  # Looks like this is only fired once, when the view is first presented
  def will_present
    Buddy.download_all
  end

  def will_appear
    reload_data

    @task_model_change_observer = Buddy.observer do |notification|
      #notification.object and notification.userData are useful. {:action=>'add'} for example
      reload_data
    end
  end

  def will_disappear
    unobserve @task_model_change_observer
  end

  def table_data
    @table_data = [{
                     cells: Buddy.all.map do |buddy|
                       {
                         title:         buddy.name.upcase,
                         date_added:    "today",
                         last_call:     "today",
                         total_calls:   42,
                         missed_call:   true,
                         action:        :select_buddy,
                         editing_style: :delete,
                         cell_class:    BuddyTableCell,
                         style:         UITableViewCellStyleDefault,
                         height:        60,
                         image:         { image: font_awesome_icon(:user, image_size: 150,
                                                                   color: stylesheet_var(:blackish),
                                                                   background_color: stylesheet_var(:green)),
                                          radius: 15
                         },
                         arguments:     { buddy: buddy }
                       }
                     end
                   }]
  end

  def reload_data
    table_data
    update_table_data
  end

  def table_data_index
    #
    #letters = []
    #@table_data.collect do |section|
    #  section[:cells].each do |cell|
    #    letters << cell[:title][0] if !letters.include?(cell[:title][0])
    #  end
    #end
    #
    #if letters.length > 15
    #  letters
    #else
    #  nil
    #end

    #('a'..'z').to_a
  end

  #def create_search_bar(params)
  #  search_bar = UISearchBar.alloc.initWithFrame(params[:frame])
  #  search_bar.autoresizingMask = UIViewAutoresizingFlexibleWidth
  #  search_bar.barStyle = UIBarStyleDefault
  #
  #  search_bar.subviews[0].removeFromSuperview
  #
  #  search_bar
  #end

  def add_buddy
    open BuddyAddScreen, in_tab: "Buddies"
    #open BuddyAddScreen, in_tab: "contacts"
  end

  def on_refresh
    Buddy.download_all do |response|
      end_refreshing
    end
  end

  def select_buddy(args)
    #args.buddy contians what you're looking for
    #TODO: Implement
    puts "Buddy selected: #{args[:buddy]}"
  end

  def on_cell_deleted(cell)
    #cell[:arguments][:buddy] is interesting...
    #TODO: Implement
    puts "Deleting #{cell[:arguments][:buddy]}"
    return false
  end
end