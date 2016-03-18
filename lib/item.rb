module CD
  class Item

    include Comparable

    attr_accessor :from,
                  :title,
                  :description,
                  :link,
                  :comments,
                  :updated_at,
                  :link_to_article,
                  :link_to_comments,
                  :link_host

    def initialize(*args)
      args.first.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def <=>(other)
      other.updated_at <=> self.updated_at
    end

    def md5
      Digest::MD5.hexdigest(self.link)
    end

    def to_hash
      self.instance_variables.inject({}) do |hash,element|
        hash[element.to_s.delete('@')] = instance_variable_get(element)
        hash
      end
    end

  end
end