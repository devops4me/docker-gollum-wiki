#!/bin/bash

# ++ +++ +++++++ # ++++++++ +++++++ # ++++++ +++++++++ # ++++++++++ # ++++++ +++++ ++ #
# ++ --- ------- # -------- ------- # ------ --------- # ---------- # ------ ----- ++ #
# ++                                                                               ++ #
# ++  Clone a git repository containing WIKI content and copy all files within the ++ #
# ++  wiki directory onto the flattened root space as it were (or configure things ++ #
# ++  so that the wiki directory is regarded as the web root.                      ++ #
# ++                                                                               ++ #
# ++ --- ------- # -------- ------- # ------ --------- # ---------- # ------ ----- ++ #
# ++ +++ +++++++ # ++++++++ +++++++ # ++++++ +++++++++ # ++++++++++ # ++++++ +++++ ++ #


echo "" ; echo "" ;
echo "### ########################################################### ###"
echo "### Clone the git repository named in the environment variable. ###"
echo "### ########################################################### ###"
echo ""

export GIT_SSL_NO_VERIFY=1 && git clone $WIKI_CONTENT_REPO_URL wiki.content.repo


echo ""
echo "### ############################################################## ###"
echo "### Run the Gollum Wiki service using the specified configuration. ###"
echo "### ############################################################## ###"
echo ""

cd wiki.content.repo && gollum --config=/var/opt/gollum/config.rb
