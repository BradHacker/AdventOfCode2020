(require '[clojure.edn :as edn])

(with-open [r (clojure.java.io/reader "input.txt")]
  (def lines (line-seq r))
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
          :else (edn/read-string (nth lines i))
        )
        :else "eof"
      )
    )
  )
  (defn find_contiguous_region
    [add_to_val]
    (loop
      [add_to add_to_val i 0]
      (cond
        (= (nth (loop
          [add_to add_to i (+ i 1) sum 0]
          (cond
            (> sum add_to) [false]
            (< sum add_to) (recur add_to (inc i) (+ sum (edn/read-string (nth lines i))))
            :else [true i]
          )
        ) 0) false) (recur add_to (inc i))
        :else [(+ i 1) (nth (loop
            [add_to add_to i (+ i 1) sum 0]
            (cond
              (> sum add_to) [false]
              (< sum add_to) (recur add_to (inc i) (+ sum (edn/read-string (nth lines i))))
              :else [true i]
            )
          ) 1)]
      )
    )
  )
  (defn get_vals
    [beg_end]
    (loop
      [vals [] end (nth beg_end 1) i (nth beg_end 0)]
      (cond
        (= i end) (conj vals (edn/read-string (nth lines i)))
        :else (recur (conj vals (edn/read-string (nth lines i))) end (inc i))
      )
    )
  )
  (defn min_max_vals
    [vals]
    (loop
      [vals vals min_max [Integer/MAX_VALUE 0] i 0]
      (cond
        (= i (count vals)) min_max
        (< (nth vals i) (nth min_max 0)) (cond
            (> (nth vals i) (nth min_max 1)) (recur vals [(nth vals i) (nth vals i)] (inc i))
            :else (recur vals [(nth vals i) (nth min_max 1)] (inc i))
          )
        (> (nth vals i) (nth min_max 1)) (cond
            (< (nth vals i) (nth min_max 0)) (recur vals [(nth vals i) (nth vals i)] (inc i))
            :else (recur vals [(nth min_max 0) (nth vals i)] (inc i))
          )
        :else (recur vals min_max (inc i))
      )
    )
  )
  (def cant_add_to (findcantaddto))
  (print "Can't add to: ")
  (println cant_add_to)
  (def contiguous_region (get_vals (find_contiguous_region cant_add_to)))
  (println contiguous_region)
  (def contiguous_min_max (min_max_vals contiguous_region))
  (print "Min of Contiguous: ")
  (println (nth contiguous_min_max 0))
  (print "Max of Contiguous: ")
  (println (nth contiguous_min_max 1))
  (print "Sum: ")
  (println (+ (nth contiguous_min_max 0) (nth contiguous_min_max 1)))
)