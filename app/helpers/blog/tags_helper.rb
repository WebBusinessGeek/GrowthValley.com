module Blog
  module TagsHelper
    NUMBER_OF_LABEL_SIZES = 5

    def label_for_tag(tag, min, max)
      "label-size-#{size_for_tag(tag, min, max)}"
    end

    def size_for_tag(tag, min, max)
      #logarithmic scaling based on the number of occurrences of each tag
      if min<max && tag.frequency>0
        1 + ((NUMBER_OF_LABEL_SIZES-1)*(log_distance_to_min(tag.frequency, min))/log_distance_to_min(max, min)).round
      else
        1
      end
    end

    private

    def log_distance_to_min(value, min)
      Math.log(value)-Math.log(min)
    end
  end
end