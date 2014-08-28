class ProfileDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator
  def_delegators :@view, :link_to, :raw

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= ['profiles.first_name', 'profiles.last_name']
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= ['profiles.last_name']
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.first_name,
        record.last_name,
        link_to(raw("Ansehen &raquo;"), record)
      ]
    end
  end

  def get_raw_records
    Profile.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
