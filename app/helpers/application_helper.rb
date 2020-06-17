module ApplicationHelper

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Muscle Platform"
    if page_title.empty?
      base_title
    else
      page_title + "｜" + base_title
    end
  end

  # ページごとの背景クラスを返します。
  def bg_style(bg_url = 'container-fruid')
    bg_url
  end
end
