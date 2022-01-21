module Admin::HyperlinksHelper
  def styles_for_links(object)
    x = object.coord_x.to_s + 'px'
    y = object.coord_y.to_s + 'px'
    w = object.coord_w.to_s + 'px'
    h = object.coord_h.to_s + 'px'
    
    "left: #{x}; top: #{y}; width: #{w}; height: #{h}; background-color: ##{object.label_color}"
  end
end