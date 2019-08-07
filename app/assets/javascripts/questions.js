// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('turbolinks:load', function() {
  const newQuestionForm = document.getElementById('new_question_form');

  if (newQuestionForm) {
    const addAnswerButton = document.getElementById('add_answer');
    let count = 0;
    addAnswerButton.addEventListener('click', addAnswerToForm);

    function addAnswerToForm() {
      ++count;
      let newField = document.createElement('div')
      newField.classList.add('field');

      let newControl = document.createElement('div');
      newControl.classList.add('control');

      let newLabel = document.createElement('label');
      newLabel.classList.add('label');
      let newLabelText = document.createTextNode("Answer " + (count + 1) + ":");
      newLabel.appendChild(newLabelText);

      let newTextInput = document.createElement('input');
      newTextInput.setAttribute('type', 'text');
      newTextInput.classList.add('input');
      newTextInput.id = "answer_text_" + count;
      newTextInput.name = 'question[answers_attributes][' + count + '][text]';

      let newRadioInputTrueLabel = document.createElement('label');
      newRadioInputTrueLabel.classList.add('radio');
      let newRadioInputTrue = document.createElement('input');
      newRadioInputTrue.setAttribute('type', 'radio');
      newRadioInputTrue.setAttribute('value', 'true');
      newRadioInputTrue.name = 'question[answers_attributes][' + count + '][truth_value]';
      newRadioInputTrue.id = "answer_true_" + count;
      newRadioInputTrueText = document.createTextNode(' True');
      newRadioInputTrueLabel.appendChild(newRadioInputTrue);
      newRadioInputTrueLabel.appendChild(newRadioInputTrueText);

      let newRadioInputFalseLabel = document.createElement('label');
      newRadioInputFalseLabel.classList.add('radio');
      let newRadioInputFalse = document.createElement('input');
      newRadioInputFalse.setAttribute('type', 'radio');
      newRadioInputFalse.setAttribute('value', 'false');
      newRadioInputFalse.name = 'question[answers_attributes][' + count + '][truth_value]';
      newRadioInputFalse.id = "answer_false_" + count;
      newRadioInputFalseText = document.createTextNode(' False');
      newRadioInputFalseLabel.appendChild(newRadioInputFalse);
      newRadioInputFalseLabel.appendChild(newRadioInputFalseText);

      newControl.appendChild(newLabel);
      newControl.appendChild(newTextInput);
      newControl.appendChild(newRadioInputTrueLabel);
      newControl.appendChild(newRadioInputFalseLabel);
      newField.appendChild(newControl);

      newQuestionForm.insertBefore(newField, addAnswerButton);
    }
  }
});
