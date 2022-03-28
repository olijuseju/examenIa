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
(assert fallo 1)
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
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot n 0 $?rest))
(assert (ncajas_robot (- ?cr ?nr)))
(assert (linea_pedido n (+ ?y ?nr) $?rest3))
)

(defrule recoger_cajas_uvas
?f <- (cajas_robot $?ini u ?ur $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (palet_uvas ?u)
(pedido n ?x $?rest2)
(linea_pedido n ?y $?rest3)
(test (> ?x ?y))
(test (< ?ur ?x))
(test (< (+ ?ur ?y) ?x))
(test (< ?cr ?*lim_cr*))
(test (> ?u 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot n (+ ?ur 1) $?rest))
(assert (ncajas_robot (+ ?cr 1)))
(assert (palet_uvas (- ?u 1) ))
)

(defrule dejar_cajas_naranjas
?f <- (cajas_robot $?ini u ?ur $?rest)
?f2 <- (ncajas_robot ?cr)
?f3 <- (linea_pedido $?ini1 u ?y $?rest1)
(test (> ?cr 0))
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot n 0 $?rest))
(assert (ncajas_robot (- ?cr ?nr)))
(assert (linea_pedido n (+ ?y ?nr) $?rest3))
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
=>
(retract ?f)
(retract ?f2)
(retract ?f3)
(assert (cajas_robot n 0 $?rest))
(assert (ncajas_robot (- ?cr ?nr)))
(assert (linea_pedido n (+ ?y ?nr) $?rest3))
)




(defrule finalizar_bien
(pedido $?res)
(linea_pedido $?res)
=>
(printout t "Se ha completado la entrega" crlf)
)

