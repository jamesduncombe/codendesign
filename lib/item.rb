# Item - class to store the info for the model of RSS data
module CD
  class Item

    attr_accessor :from, :title, :description, :link, :comments, :updated_at

    def initialize(*args)
      args.first.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def link_to_article
      if self.from == 'design'
        # protect against questions asked on designer news
        return self.description if self.description.start_with? 'http'
        self.link
      else
        self.link
      end
    end

    def link_to_comments
      if self.from == 'design'
        self.link
      else
        self.comments
      end
    end

    def link_host
      URI(self.link_to_article.split('#').first.gsub(/[^\w_\/-:.]*/, '')).host
    end

    def tweet
      if self.from == 'design'
        "#{self.title} - #{self.link_to_article} via news.layervault.com"
      else
        "#{self.title} - #{self.link_to_article} via @hackernews"
      end
    end

    def to_hash
      self.instance_variables.inject({}) do |hash,element|
        hash[element.to_s.delete('@')] = instance_variable_get(element)
        hash
      end
    end

  end
end