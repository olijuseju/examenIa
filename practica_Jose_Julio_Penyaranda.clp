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

