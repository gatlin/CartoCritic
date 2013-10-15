/*global define */
'use strict';

var app = angular.module('myApp',[
    'ngRoute',
    'ui.jq',
    'angularFileUpload',
    'appCtrl'
]).

config(['$routeProvider',
    function($routeProvider) {
      $routeProvider.
        when('/help', {
            templateUrl: 'views/help.html'
        }).
        when('/account', {
            templateUrl: 'views/account.html',
            controller: 'AccountCtrl'
        }).
        when('/login', {
            templateUrl: 'views/login.html',
            controller: 'LoginCtrl'
        }).
        when('/classes', {
            templateUrl: 'views/main.html',
            controller: 'MainCtrl'
        }).
        when('/classes/new', {
            templateUrl: 'views/class-new.html',
            controller: 'ClassNewCtrl'
        }).
        when('/classes/:id', {
            templateUrl: 'views/class-view.html',
            controller: 'ClassViewCtrl'
        }).
        when('/classes/edit/:id', {
            templateUrl: 'views/class-edit.html',
            controller: 'ClassEditCtrl'
        }).
        when('/classes/:id/:viewing', {
            templateUrl: 'views/class-view.html',
            controller: 'ClassViewCtrl'
        }).
        when('/class-assignment/:id',{
            templateUrl: 'views/class-assignment.html',
            controller: 'ClassAssignmentCtrl'
        }).
        when('/assignments/:id',{
            templateUrl: 'views/assignment.html',
            controller: 'AssignmentCtrl'
        }).
        when('/map/:id', {
            templateUrl: 'views/map.html',
            controller: 'MapCtrl'
        }).
        when('/critique/:id', {
            templateUrl: 'views/critique.html',
            controller: 'CritiqueCtrl'
        }).
        /*
        when('/student-assignment/:id',{
            templateUrl: 'views/student-assignment.html',
            controller: 'StudentAssignmentCtrl'
        }).*/
        otherwise({
            redirectTo: '/classes'
        });
}]);

