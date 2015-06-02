module Features
  module SearchHelpers
    def search_reindex(klass)
      if klass
        klass.reindex 
        klass.searchkick_index.refresh
      end
    end
  end
end
