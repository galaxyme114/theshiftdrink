class PageSerializer < ActiveModel::Serializer

  def position_in_article
    object.position
  end

  def meta
    {
			content:			object.article.content,
			hyperlinks:		object.hyperlinks,
			interstitial:	object.full_page_ad,
		}
  end

  def images
    {
			large:				object.image_url(:large),
			social:				object.article.social_thumbnail
    }
  end

  def article
		article = object.article
    {
			friendly_id:	article.friendly_id,
			id:						article.id,
			title:				article.title,
			title_pic:		article.title_pic_url,
			media_count:	article.media_count,
			description:	article.description
    }
  end

  attributes :id, :friendly_id, :master_position, :position_in_article, :article, :images, :meta
end
