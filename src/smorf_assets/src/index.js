import { smorf } from "../../declarations/smorf";
import { createApp } from "../assets/vue/vue.esm-browser.prod";

//import { createApp } from 'vue'

  createApp({
    data() {
      return {
        message: 'Hello!',
        input: {
          message: "",
        },
        isLoading: false,
      }
    },
    methods: {
      greet() {
        this.isLoading = true;
        smorf.greet(this.input.message)
        .then(greeting => {
          this.message = greeting;
          this.input.message = "";
          this.isLoading = false;
        })
        .catch(err => {
          console.log(err);
          this.isLoading = false;
        });
      },
    },
    mounted() {
      console.log(`initial message is ${this.message}.`)
    },
  }).mount('#app');

