(defglobal ?*lim_cr* = 3)

(deffacts inicial
(ncajas_robot 0)
(cajas_robot n 0 m 0 q 0 u 0)
(palet_naranjas 3)
(palet_uvas 3)
(palet_manzanas 3)
(palet_caquis 3)
(pedido n 2 m 3 q 0 u 1)
(linea_pedido n 0 m 0 q 0 u 0)
(fallo 0)
)

(defrule comprobar_pedido
?f <- (fallo ?fa)
(palet_naranjas ?n)
(palet_uvas ?u)
(palet_manzanas ?m)
(palet_caquis ?q)
(pedido n ?x m ?y q ?z u ?w)
(test (< ?n ?x))
(test (< ?u ?w))
(test (< ?m ?y))
(test (< ?q ?z))
=>
(retract ?f)
(assert (fallo 1))
)

(defrule finalizar_error
?f <- (fallo ?fa)
(test (= ?fa 1))
=>
(printout t "No hay suficientes cajas para cumplir con el pedido" crlf)
(halt)
)

(defrule recoger_cajas_naranjas
?f <- (cajas_robot n ?nr $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (palet_naranjas ?n)
(pedido n ?x $?rest2)
(linea_pedido n ?y $?rest3)
(test (> ?x ?y))
(test (< ?nr ?x))
(test (< (+ ?nr ?y) ?x))
(test (< ?cr ?*lim_cr*))
(test (> ?n 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot n (+ ?nr 1) $?rest))
(assert (ncajas_robot (+ ?cr 1)))
(assert (palet_naranjas (- ?n 1) ))
)

(defrule dejar_cajas_naranjas
?f <- (cajas_robot n ?nr $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (linea_pedido n ?y $?rest3)
(test (> ?cr 0))
(test (> ?nr 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot n 0 $?rest))
(assert (ncajas_robot (- ?cr ?nr)))
(assert (linea_pedido n (+ ?y ?nr) $?rest3))
(printout t "Linea pedido: " n (+ ?y ?nr) $?rest3 crlf)

)

(defrule recoger_cajas_uvas
?f <- (cajas_robot $?ini u ?ur)
?f2 <- (ncajas_robot ?cr)
?f3 <- (palet_uvas ?u)
(pedido $?ini2 u ?x)
(linea_pedido $?ini2 u ?y)
(test (> ?x ?y))
(test (< ?ur ?x))
(test (< (+ ?ur ?y) ?x))
(test (< ?cr ?*lim_cr*))
(test (> ?u 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot $?ini u (+ ?ur 1)))
(assert (ncajas_robot (+ ?cr 1)))
(assert (palet_uvas (- ?u 1) ))
)

(defrule dejar_cajas_uvas
?f <- (cajas_robot $?ini u ?ur)
?f2 <- (ncajas_robot ?cr)
?f3 <- (linea_pedido $?ini1 u ?y)
(test (> ?cr 0))
(test (> ?ur 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot $?ini u 0))
(assert (ncajas_robot (- ?cr ?ur)))
(assert (linea_pedido $?ini1 u (+ ?y ?ur)))
(printout t "Linea pedido: " $?ini1 u (+ ?y ?ur) crlf)

)

(defrule recoger_cajas_caquis
?f <- (cajas_robot $?ini q ?qr $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (palet_caquis ?n)
(pedido $?ini2 q ?x $?rest2)
(linea_pedido $?ini2 q ?y $?rest3)
(test (> ?x ?y))
(test (< ?qr ?x))
(test (< (+ ?qr ?y) ?x))
(test (< ?cr ?*lim_cr*))
(test (> ?n 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot $?ini q (+ ?qr 1) $?rest))
(assert (ncajas_robot (+ ?cr 1)))
(assert (palet_caquis (- ?n 1) ))
)

(defrule dejar_cajas_caquis
?f <- (cajas_robot $?ini q ?qr $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (linea_pedido $?ini1 q ?y $?rest1)
(test (> ?cr 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot $?ini q 0 $?rest))
(assert (ncajas_robot (- ?cr ?qr)))
(assert (linea_pedido $?ini1 q (+ ?y ?qr) $?rest1))
(printout t "Linea pedido: " $?ini1 q (+ ?y ?qr) $?rest1 crlf)

)






(defrule recoger_cajas_manzanas
?f <- (cajas_robot $?ini m ?mr $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (palet_manzanas ?m)
(pedido $?ini2 m ?x $?rest2)
(linea_pedido $?ini2 m ?y $?rest3)
(test (> ?x ?y))
(test (< ?mr ?x))
(test (< (+ ?mr ?y) ?x))
(test (< ?cr ?*lim_cr*))
(test (> ?m 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot $?ini m (+ ?mr 1) $?rest))
(assert (ncajas_robot (+ ?cr 1)))
(assert (palet_manzanas (- ?m 1) ))
)

(defrule dejar_cajas_manzanas
?f <- (cajas_robot $?ini m ?mr $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (linea_pedido $?ini1 m ?y $?rest1)
(test (> ?cr 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot $?ini m 0 $?rest))
(assert (ncajas_robot (- ?cr ?mr)))
(assert (linea_pedido $?ini1 m (+ ?y ?mr) $?rest1))
(printout t "Linea pedido: " $?ini1 m (+ ?y ?mr) $?rest1 crlf)

)







(defrule finalizar_bien
(pedido $?res)
(linea_pedido $?res)
=>
(printout t "Linea pedido: " $?res crlf)
(printout t "Pedido: " $?res crlf)
(printout t "Se ha completado la entrega" crlf)
(halt)
)

