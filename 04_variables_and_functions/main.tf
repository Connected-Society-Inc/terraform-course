# Functions: https://www.terraform.io/docs/language/functions/index.html

locals {
    instance_type = "f1-micro" # static, cannot be overriden by the user

    v_bool = true
    v_num  = 12

    v_list = ["a", "b", "c"]
    v_map  = { a = 1, b = 2, c = 3 }

    v_file = file("main.tf")
}

