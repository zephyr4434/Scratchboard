module ApplicationHelper

  def title
    base_title = "Scratchboard"
      if @title.nil?
        base_title
      else
        @title
      end
  end
  
  def logo
    image_tag("logo.png", :alt => "Scratchboard", :class => ":round")
  end
  
  def logo_small
    image_tag("mark.jpg", :alt => "Scratchboard", :class => ":round")
  end
  
end
