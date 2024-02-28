package nemo.gencode.controller;

import nemo.gencode.model.FormRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("")
    public String viewHomePage(Model model) {
        FormRequest formRequest = new FormRequest();
        model.addAttribute(formRequest);

        return "index";
    }
}
