(import
  [trytond.pool [Pool]]
  [trytond.model [ModelView fields]]
  [trytond.pyson [PYSONEncoder]]
  [trytond.wizard [Wizard StateAction StateView StateTransition Button]])
(def --all-- ["HelloStart" "HelloWizard" "HelloSelectUser"])

(defclass HelloStart [ModelView]
  "Hello Start"
  [--name-- "hello.wizard.start"])

(defclass HelloSelectUser [ModelView]
  "Hello Select User"
  [--name-- "hello.wizard.select_user"
   user (.Many2One fields "res.user" "User")])

(defclass HelloWizard [Wizard]
  "Hello Wizard"
  [--name-- "hello.wizard"
   start (StateView "hello.wizard.start"
                    "hello_wizard.hello_wizard_start_form"
                    [(Button "Cancel" "end" "tryton-cancel")
                     (Button "Next" "select_user" "tryton-ok" :default True)])
   select-user (StateView
                  "hello.wizard.select_user"
                  "hello_wizard.hello_wizard_select_user_form"
                  [(Button "Cancel" "end" "tryton-cancel")
                   (Button "Next" "create_hello" "tryton-ok" :default True)])
   create-hello (StateTransition)
   display-hello (StateAction "hello.act_hello")]


  (defn do-display-hello [self action]
    (assoc action "pyson_domain"
           (.encode (PYSONEncoder) [(, "name" "=" self.select-user.user.name)]))
    (, action {}))
  
  (defn transition-display-hello [self]
    "end")
  
  (defn transition-create-hello [self]
    (setv
      user self.select-user.user
      Hello (.get (Pool) "hello")
      hello (Hello :name user.name :surname "from-user" :code "x"))
    (.save hello)
    "display_hello"
    )
  )
