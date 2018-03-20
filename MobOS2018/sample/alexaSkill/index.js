/* eslint-disable  func-names */
/* eslint quote-props: ["error", "consistent"]*/
/**
 * This sample demonstrates a sample skill built with Amazon Alexa Skills nodejs
 * skill development kit.
 * The Intent Schema, Custom Slot and Sample Utterances for this skill, as well
 * as testing instructions are located at https://github.com/alexa/skill-sample-nodejs-howto
 **/

'use strict';

const Alexa = require('alexa-sdk');

const APP_ID = 'amzn1.ask.skill.2046055a-4d46-427c-90db-2fad4217a88c'; // TODO replace with your app ID (OPTIONAL).

const languageStrings = {
    'en': {
        translation: {
            SKILL_NAME: 'Jarvis',
            WELCOME_MESSAGE: "Hi, I am Jarvis. You can ask me a question like, who\'s the winner in this room? ... Now, what can I help you with?",
            WELCOME_REPROMPT: 'For instructions on what else you can say, please say help me.',
            DISPLAY_CARD_TITLE: '%s  - Recipe for %s.',
            HELP_MESSAGE: "You can ask questions such as, pick me a winner, or, you can say exit...Now, what can I help you with?",
            HELP_REPROMPT: "You can say things like, who\'s the winner in this room, or you can say exit...Now, what can I help you with?",
            STOP_MESSAGE: 'Goodbye!',
            REPEAT_MESSAGE: 'Try saying repeat.',
            RESOLVE_ROW_MESSAGE: 'Can you tell me the rows count?',
            RESOLVE_COLUMN_MESSAGE: 'Can you tell me the columns count?',
            RESPONSE_RANDOM_POINT: 'The winner ... is located in  ',
            ERR_NOT_FOUND_MESSAGE: "I\'m sorry, I currently do not know ",
            ERR_NOT_FOUND_WITH_ITEM_NAME: 'the recipe for %s. ',
            ERR_NOT_FOUND_WITHOUT_ITEM_NAME: 'that recipe. ',
            ERR_NOT_FOUND_REPROMPT: 'What else can I help with?',
            
        },
    },
};

let row = null;
let column = null;
let hasResolvedRow = false;
let hasResolvedColumn = false;


function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function resetSessionVariables() {
    row = null;
    column = null;
    hasResolvedRow = false;
    hasResolvedColumn = false;
}


const handlers = {
    'LaunchRequest': function () {
        this.attributes.speechOutput = this.t('WELCOME_MESSAGE', this.t('SKILL_NAME'));
        // If the user either does not reply to the welcome message or says something that is not
        // understood, they will be prompted again with this text.
        this.attributes.repromptSpeech = this.t('WELCOME_REPROMPT');
        this.emit(':ask', this.attributes.speechOutput, this.attributes.repromptSpeech);
    },
    'PickAWinner': function() {
        const rowSlot = this.event.request.intent.slots.Row;
        const columnSlot = this.event.request.intent.slots.Column;
        
        if (rowSlot && rowSlot.value) {
            row = rowSlot.value;
        }

        if (columnSlot && columnSlot.value) {
            column = columnSlot.value;
        }
        
        if (!row && !hasResolvedRow) {
            hasResolvedRow = true;
            let speechOutput = this.t('RESOLVE_ROW_MESSAGE');
            this.attributes.speechOutput = speechOutput;
            this.emit(':ask', speechOutput);
        } else if (!column && !hasResolvedColumn) {
            hasResolvedColumn = true;
            let speechOutput = this.t('RESOLVE_COLUMN_MESSAGE');
            this.attributes.speechOutput = speechOutput;
            this.emit(':ask', speechOutput);
        } else if (row && column) {
            let speechOutput = this.t('RESPONSE_RANDOM_POINT');
            speechOutput += 'row number' + getRandomInt(1, row) + ", at seat number " + getRandomInt(1, column) + ". Congratulations!";
            this.attributes.speechOutput = speechOutput;
            this.emit(':tell', speechOutput);
            resetSessionVariables();
        } else {
             this.attributes.speechOutput = this.t('HELP_MESSAGE');
            this.attributes.repromptSpeech = this.t('HELP_REPROMPT');
            this.emit(':ask', this.attributes.speechOutput, this.attributes.repromptSpeech);
            resetSessionVariables();
        }
    },
    'AMAZON.HelpIntent': function () {
        this.attributes.speechOutput = this.t('HELP_MESSAGE');
        this.attributes.repromptSpeech = this.t('HELP_REPROMPT');
        this.emit(':ask', this.attributes.speechOutput, this.attributes.repromptSpeech);
    },
    'AMAZON.RepeatIntent': function () {
        this.emit(':ask', this.attributes.speechOutput, this.attributes.repromptSpeech);
    },
    'AMAZON.StopIntent': function () {
        this.emit('SessionEndedRequest');
    },
    'AMAZON.CancelIntent': function () {
        this.emit('SessionEndedRequest');
    },
    'SessionEndedRequest': function () {
        this.emit(':tell', this.t('STOP_MESSAGE'));
    },
    'Unhandled': function () {
        this.attributes.speechOutput = this.t('HELP_MESSAGE');
        this.attributes.repromptSpeech = this.t('HELP_REPROMPT');
        this.emit(':ask', this.attributes.speechOutput, this.attributes.repromptSpeech);
    },
};

exports.handler = function (event, context) {
    const alexa = Alexa.handler(event, context);
    alexa.APP_ID = APP_ID;
    // To enable string internationalization (i18n) features, set a resources object.
    alexa.resources = languageStrings;
    alexa.registerHandlers(handlers);
    alexa.execute();
};
