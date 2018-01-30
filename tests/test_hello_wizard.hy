(import [unittest]
        [trytond.tests.test_tryton]
        [trytond.tests.test_tryton [ModuleTestCase with_transaction]]
        [trytond.pool [Pool]])


(defclass HelloTestCase [ModuleTestCase]
  "Test Hello Module"
  [module "hello_wizard"])



(defn suite []
  (setv suite (.suite trytond.tests.test_tryton))
  (.addTests suite
             (.loadTestsFromTestCase
               (.TestLoader unittest) HelloTestCase))
  suite)
