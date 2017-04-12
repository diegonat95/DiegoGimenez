;Hardcode	the	true	atom	to	this	for	simplicity
(def continue-running? (atom true))

;Counter of number of customers fed
(def people-fed (atom 0))

;Queue of customers waiting
(def waiting-room (ref []))

;Atom presenting seats to wait in
(def waiting-room-size 3)

;Check	to	see	if	anyone	is	waiting	in the	3	seats	or	not
(defn anyone-waiting []
  (if
    (= waiting-room 0) "no" "yes")
  )

;Check if there's any seats available
(defn free-seat []
  (if
    (< (count (ensure waiting-room)) waiting-room-size)
    "yes" "no"
    )
  )

;Sleep for 1min (ms) to avoid resource issues then have the chef
;try to feed another customer
(defn move-to-kitchen [duration]
    (Thread/sleep duration)
)

;Choose the time the restaurant is open for
(defn open-restaurant [duration]
    (Thread/sleep duration)
    (swap! continue-running? not)
)

;Have a customer arrive every 10 to 30 minutes (ms)
(defn customer-arrive []
    (future

        ;While busines is open and seats available keep adding customers to queue
        (while
            @continue-running?

            (println "Waiting Room:" @waiting-room)

            (dosync
                (if (= "yes" (free-seat))
                    ;add customer to available seat
                    (alter waiting-room conj :customer)
                )
            )
            ;Wait 10 to 30 minutes (ms) before any other customer arrives
            (Thread/sleep
                (+ 10 (rand-int 21))
            )
        )
    )
)
;If someone is waiting bring them in and feed them. This takes 20 minutes (ms)
;Increase the count of number of people fed
(defn serve-food []
    (future
        (while
            @continue-running?

            (if (= "yes" (anyone-waiting))
              (when-let
                  [
                      next-customer

                      (dosync

                          (let
                              [
                                  next-customer
                                  (first (ensure waiting-room))
                              ]

                              (when
                                  next-customer

                                  (alter waiting-room rest)

                                  next-customer
                              )
                          )

                      )
                  ]

                  ; Moving customer to kitchen takes 1min (ms)
                  ;(move-to-kitchen (1))
                  (Thread/sleep 1)

                  (println "Serving customer:" @people-fed)

                  ;Chef serves food. Takes 20 minutes (ms)
                  (Thread/sleep 20)

                  ;Increment count people fed
                  (swap! people-fed inc)

              )
            )
        )

    )

)


;Start up serving food
(serve-food)

;Start up customers arriving every 10 or 30 minutes (ms)
(customer-arrive)

;The restaurant is open for 10 hours (10,000ms)
(open-restaurant (* 10 1000))

;Output counter of customers fed
(println "Number of people fed today:" @people-fed)
