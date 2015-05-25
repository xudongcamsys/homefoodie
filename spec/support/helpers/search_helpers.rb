module Features
  module SessionHelpers
    def search_reindex(klass_name)
      klass = klass_name.constantize
      if klass
        klass.reindex 
        klass.searchkick_index.refresh
      end
    end
  end
end
