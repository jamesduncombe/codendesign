module CD
  class Item

    include Comparable

    attr_reader :params

    attr_accessor :from,
                  :title,
                  :description,
                  :link,
                  :comments,
                  :updated_at,
                  :link_to_article,
                  :link_to_comments,
                  :link_host

    def initialize(params = {})
      @params = params
      params.each do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    def <=>(other)
      other.updated_at <=> self.updated_at
    end

    def md5
      Digest::MD5.hexdigest(self.link)
    end

    def to_hash
      params
    end

  end
end