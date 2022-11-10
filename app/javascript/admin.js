// Entry point for the build script in your package.json
import '@hotwired/turbo-rails';
import './controllers';
import * as bootstrap from 'bootstrap';
//import './admin/js/jquery'
import './admin/js/app';
import Choices from 'choices.js';

//document.addEventListener("turbolinks:load", function() {
const choices_user = new Choices('.js-choice-user');
const choices_place = new Choices('.js-choice-place');

//})

console.log('I am the default admin.js');
