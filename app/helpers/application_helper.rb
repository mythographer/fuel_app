module ApplicationHelper
    def bootstrap_gliphicon_sign_for(message_type)
      "glyphicon-%s-sign" % { success: 'ok',
                              info: 'info',
                              warning: 'warning',
                              danger: 'exclamation' }[message_type.to_sym]
    end
end
