class BuddyScreen < PM::TableScreen
  include YinsiHelpers

  title "Buddies"
  indexable
  searchable placeholder: "Search for a buddy..."
  refreshable callback: :on_refresh,
              pull_message: "Pull to refresh",
              refreshing: "Refreshing data…",
              updated_format: "Last updated at %s",
              updated_time_format: "%l:%M %p"

  stylesheet :buddy

  def on_init
    set_tab_icon(:group, "Buddies")
    self.view.stylename = :root

    set_nav_bar_button :right, system_item: :add, action: :add_buddy
    set_nav_bar_button :back, title: 'Cancel', style: :plain, action: :back

    # Style the navigation bar (& buttons in it)
    self.navigationController.navigationBar.configureFlatNavigationBarWithColor(stylesheet_var(:green_medium))
    UIBarButtonItem.configureFlatButtonsWithColor stylesheet_var(:grey_dark),
      highlightedColor: stylesheet_var(:grey),
      cornerRadius: 3

    table_view.contentOffset = CGPointMake(0, 44)
  end

  # Looks like this is only fired once, when the view is first presented
  def will_present
    download_table_data
  end

  def table_data
    @table_data ||= []
  end

  def download_table_data
    Buddy.download_all do
      @table_data = [{
                       cells: Buddy.all.map do |buddy|
                         {
                           title:         buddy.name,
                           action:        :select_buddy,
                           editing_style: :delete,
                           arguments:     { buddy: buddy }
                         }
                       end
                     }]
      update_table_data
    end
  end

  def table_data_index
    #all_rows = []
    #table_data.each do |section|
    #  section[:cells].each do |cell|
    #    all_rows << cell[:title][0] if !all_rows.include?(cell[:title][0])
    #  end
    #end
    ('a'..'z').to_a
  end

  def create_search_bar(params)
    search_bar = UISearchBar.alloc.initWithFrame(params[:frame])
    search_bar.autoresizingMask = UIViewAutoresizingFlexibleWidth
    search_bar.barStyle = UIBarStyleDefault

    search_bar.subviews[0].removeFromSuperview

    search_bar
  end

  def add_buddy
    open BuddyAddScreen, in_tab: "Buddies"
  end

  def on_refresh
    download_table_data
    end_refreshing
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