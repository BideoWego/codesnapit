module Searchable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    @searchable_fields = []
    @searchable_scope = nil

    def search(q, method=nil)
      search_method = resolve_search_method(method)
      self.send(search_method, q)
    end

    def search_by_fields(q, fields=nil)
      fields = searchable_fields unless fields
      sql = fields.map {|field| "#{field} LIKE ?"}.join(' OR ')
      parameters = fields.map {"%#{q}%"}
      where(sql, *parameters)
    end

    def search_by_scope(q, scope=nil)
      scope = searchable_scope unless scope
      scope.call(q)
    end

    def searchable_scope(scope=nil)
      @searchable_scope = scope unless scope.nil?
      @searchable_scope
    end

    def searchable_fields(*fields)
      @searchable_fields = fields if fields.present?
      @searchable_fields
    end


    private
    def resolve_search_method(method)
      method = method.downcase.to_sym unless method.nil?
      if method == :searchable_fields ||
        searchable_fields.present? && searchable_scope.nil?
        :search_by_fields
      elsif method == :searchable_scope ||
        !searchable_scope.nil? && searchable_fields.empty?
        :search_by_scope
      else
        raise "Unable to determine search method within #{self}, you must declare exactly one search method in the including class"
      end
    end
  end
end