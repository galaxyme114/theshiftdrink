module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

	def admin_with_sidebar?(controller_name)
		['pages', 'photos', 'articles', 'hyperlinks'].include?(controller_name)
	end

  def layout_length
    return ( admin_with_sidebar?(controller_name) ) ? '9' : '12'
  end

  def activated_media(param, media)
    ( param == media || (media == 'photo' && param != 'video')) ? 'active' : ''
  end

  def assets_endpoint
  	unless Rails.env.production?
  	  return 'http://localhost:3000'
  	end

  	return 'http://www.realtheshiftdrink.com'
  end

  def box_position(position, offset = 0)
  	( position ||= 1) + offset
  end

  def sidebar_thumbnail_for(page, articles, opts = {})
    article = articles.select { |a| a.id == page.article_id }[0]
	url = ( page.position == 1 && article.custom_thumb? ) ? article.thumbnail_url : page.image_url(:thumb)
    image_tag url, opts
  end

  def article_thumbnail_for(article, opts = {})
    url = ( article.custom_thumb? ) ? article.thumbnail_url : article.pages.first.image_url(:thumb)
    image_tag url, opts
  end

  def thumbnail_for_media(media, opts = {})
    url = ( media.asset.blank? ) ? 'https://image.freepik.com/free-icon/external-link_318-10070.jpg' : media.asset_url
    image_tag url, opts
  end

  def avatar_for(user)
    image_tag ( user.uid.blank? ) ? 'https://s3-us-west-2.amazonaws.com/simpuli/assets/avatars/default.png' : "http://graph.facebook.com/#{user.uid}/picture"
  end
end
