// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('turbolinks:load', function() {

  console.log('questions.js');
  const newQuestionForm = document.getElementById('new_question_form');
  var count = 1;

  if (newQuestionForm) {
    console.log('has NewQuestionForm');
    const addAnswerButton = document.getElementById('add_answer');
    addAnswerButton.addEventListener('click', addAnswerToForm);
  }

  function addAnswerToForm() {
    console.log('addAnswerToForm');
    ++count;

    let newTextInput = document.createElement('input');
    newTextInput.setAttribute('type', 'text');
    newTextInput.classList.add('input');
    newTextInput.name = 'question[answer_' + count + '][text]';
    newQuestionForm.appendChild(newTextInput);

    let newRadioInputTrue = document.createElement('input');
    newRadioInputTrue.setAttribute('type', 'radio');
    newRadioInputTrue.setAttribute('value', 'true');
    newRadioInputTrue.name = 'question[answer_' + count + '][truth_value]';
    newQuestionForm.appendChild(newRadioInputTrue);

    // let newRadioLabelTrue = document.createElement('label');

    let newRadioInputFalse = document.createElement('input');
    newRadioInputFalse.setAttribute('type', 'radio');
    newRadioInputFalse.setAttribute('value', 'false');
    newRadioInputFalse.name = 'question[answer_' + count + '][truth_value]';
    newQuestionForm.appendChild(newRadioInputFalse);

    // let newRadioLabelFalse = document.createElement('label');
  }
});
