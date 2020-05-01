module ApplicationHelper
	def pagination_links(collection, options = {})
   options[:renderer] ||= BootstrapPaginationHelper::LinkRenderer
   options[:inner_window] ||= 1
   options[:outer_window] ||= 0
   will_paginate(collection, options)
 end

  def truncate_blast_message blast_message
    message = ''
    full_message = ''
    msg_count = 0
    find_limit = nil
    next_stack = ''
    blast_message.split(">").each{|a|
      next if a[0..3] == '<img'
      if a[0] == '<'
        message += "#{a}>"
      else
        msg_count_before_inject = msg_count
        text = a.split('<')[0]
        msg_count += text.size
        if msg_count > 184
          if find_limit.blank?
            message += "#{text.truncate(184-msg_count_before_inject)}<#{a.split('<')[1]}>"
          else
            message += "<#{a.split('<')[1]}>"
          end
          find_limit = 1
        else
          message += "#{a}>"
        end
      end
    }
    raw message
  end

  def truncate_article article, size
    message = ''
    full_message = ''
    msg_count = 0
    find_limit = nil
    next_stack = ''
    article.split(">").each{|a|
      next if a[0..3] == '<img'
      if a[0] == '<'
        message += "#{a}>"
      else
        msg_count_before_inject = msg_count
        text = a.split('<')[0]
        msg_count += text.size
        if msg_count > size
          if find_limit.blank?
            message += "#{text.truncate(size-msg_count_before_inject)}<#{a.split('<')[1]}>"
          else
            message += "<#{a.split('<')[1]}>"
          end
          find_limit = 1
        else
          message += "#{a}>"
        end
      end
    }
    raw message.gsub('<p></p>', '')
  end

  def content_only article
    msg = ''
    article.split('>').each{|a|
      msg += a.split('<')[0] unless a[0] == '<'
    }
    msg
  end
end