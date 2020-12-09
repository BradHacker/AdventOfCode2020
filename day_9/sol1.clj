(require '[clojure.edn :as edn])

(with-open [r (clojure.java.io/reader "input.txt")]
  (def lines (line-seq r))
  (println (count lines))
  (defn canaddto
    [i]
    (loop
      [add_to (edn/read-string (nth lines i)) num_1 (- i 25) num_2 (- i 25)]
      (cond
        (and (= num_1 i) (= num_2 i)) false
        (= num_2 i) (recur add_to (inc num_1) 0)
        (= num_1 num_2) (recur add_to num_1 (inc num_2))
        (= (+ (edn/read-string (nth lines num_1)) (edn/read-string (nth lines num_2))) add_to) true
        :else (recur add_to num_1 (inc num_2))
      )
    )
  )
  (defn findcantaddto
    []
    (loop
      [i 0 nums []]
      (cond
        (< i 25) (recur (inc i) (conj nums (edn/read-string (nth lines i))))
        (< i (count lines)) (cond
          (= (canaddto i) true) (recur (inc i) (conj (pop nums) (edn/read-string (nth lines i))))
          :else (nth lines i)
        )
        :else "eof"
      )
    )
  )
  (println (findcantaddto))
)