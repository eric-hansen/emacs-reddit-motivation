(pkg 'request)

(defun reddit-motivation ()
  "Fetches a (random) Imgur link from /r/GetMotivated and load it in the browser"
  (interactive)
  (request
    "http://www.reddit.com/r/GetMotivated/search.json?q=site%3Ai.imgur.com&restrict_sr=on&sort=relevance&t=link"
    :parser 'json-read
    :success (function*
        (lambda (&key data &allow-other-keys)
          ;; data -> children -> <random> -> data -> url
          (let imgurl 
		(cdr 
			(assoc 'url 
				(cdr 
					(assoc 'data 
						(cdr 
							(assoc 0 
								(cdr 
									(assoc 'children 
										(cdr 
											(assoc 'data data)
										)
									)
								)
							)
						)
					)
				)
			)
		)
	)
          (message "IMGUR URL: %s" imgurl)
        )
    )
  ))

(provide 'reddit-motivation)
