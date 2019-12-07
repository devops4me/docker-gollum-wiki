# --- ----------------------------------------- --- #
# --- Directives that configure our Gollum wiki --- #
# --- ----------------------------------------- --- #

wiki_options = {
 :h1_title         => true,
 :universal_toc    => false,
 :user_icons       => 'gravatar',
 :template_dir     => 'templates',
 :live_preview     => true,
 :allow_uploads    => false,
 :per_page_uploads => false,
 :allow_editing    => false,
 :css              => true,
 :js               => false,
 :mathjax          => true,
 :emoji            => true,
 :reverse_links    => true,
 :show_all         => true
}

# --- -------------------------------------- --- #
# --- Set the above configuration directives --- #
# --- -------------------------------------- --- #
Precious::App.set(:wiki_options, wiki_options)
