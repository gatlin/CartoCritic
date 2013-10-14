'use strict';

var appCtrl = angular.module('appCtrl',[]);

appCtrl.controller('MainCtrl',['$scope','$http',
    function ($scope,$http) {
        $scope.username = '';
        console.log("MainCtrl");
        $scope.editing = "0";

        $http.get('/app/userinfo').
            success(function(data,success) {
                $scope.username = data.username;
                $scope.name = data.fname + ' ' + data.lname;
            });

        $http.get('/api/v1/classes').
            success(function(data,success) {
                $scope.classes = data;
            });

        $scope.rmClasses = function() {
            angular.forEach($scope.classes, function(val,key) {
                if (val.checked) {
                    $http.delete('/api/v1/classes/'+val.id).
                        success(function(data,success) {
                            $scope.classes.splice(key,1);
                        });
                }
            });
        };
    }
]);

appCtrl.controller('ClassNewCtrl',['$scope','$http','$location',
    function($scope,$http,$location) {
        console.log('ClassNewCtrl');

        $scope.class_ = {
            title: '',
            semester: '',
            archived: 0
        };

        $scope.saveClass = function() {
            $http.post('/api/v1/classes/',$scope.class_).
                success(function(data,success) {
                    console.log(success);
                    $location.path('/classes');
                });
        };
    }
]);

appCtrl.controller('ClassEditCtrl', ['$scope','$http','$routeParams','$location',
    function($scope,$http,$routeParams,$location) {
        console.log('ClassEditCtrl');

        var id = $routeParams.id;
        $scope.id = id;

        $scope.class_ = {};
        $http.get('/api/v1/classes/'+$routeParams.id).
            success(function(data,success) {
                $scope.class_ = data;
            });

        $scope.saveClass = function() {
            $http.put('/api/v1/classes/'+$routeParams.id,$scope.class_).
                success(function(data,success) {
                    $location.path('/classes/'+$routeParams.id);
                });
        };
    }
]);

appCtrl.controller('ClassViewCtrl',['$scope','$http','$routeParams',
    function ($scope,$http,$routeParams) {
        console.log("ClassViewCtrl");
        var id = $routeParams.id;
        $scope.id = id;
        $scope.students = [];
        if ($routeParams.viewing) {
            $scope.viewing = $routeParams.viewing;
        }
        else {
            $scope.viewing = "students";
        }
        $scope.assignments = [];
        $scope.newAssignmentObj = false;
        $scope.editing = false;
        $scope.newStudentObj = false;

        $http.get('/api/v1/classes/'+$routeParams.id).
            success(function(data,success) {
                $scope.class_ = data;
            });

        $http.get('/api/v1/classes/'+$routeParams.id+'/students').
            success(function(data,success) {
                $scope.students = data;
            });

        $scope.rmStudents = function() {
            angular.forEach($scope.students,function(val,key) {
                if (val.checked) {
                    $http.delete('/api/v1/students/'+val.id).
                        success(function(data,success) {
                            $scope.students.splice(key,1);
                        });
                }
            });
        };

        $scope.newStudent = function() {
            $scope.newStudentObj = {
                fname: '',
                lname: '',
                email: '',
                class: $routeParams.id,
            };
            $scope.students.unshift($scope.newStudentObj);
        };

        $scope.saveStudent = function() {
            $http.post('/api/v1/students/',$scope.newStudentObj)
                .success(function(data,success) {
                    $scope.newStudentObj = false;
                });
        };

        $scope.discardStudent = function() {
            $scope.students.splice(0,1);
            $scope.newStudentObj = false;
        };

        $http.get('/api/v1/classes/'+id+'/assignments').
            success(function(data,success) {
                angular.forEach(data,function(val,key) {
                    $scope.assignments.unshift(val);
                    $('#datetimepicker'+data.id+' input').val(val.due);
                });
            });

        $scope.rmAssignments = function() {
            angular.forEach($scope.assignments,function(val,key) {
                if (val.checked) {
                    $http.delete('/api/v1/assignments/'+val.id).
                        success(function(data,success) {
                            $scope.assignments.splice(key,1);
                        });
                }
            });
        };

        $scope.newAssignment = function() {
            $scope.newAssignmentObj = {
                class_id: $scope.id,
                id: 0,
                name: '',
                due: '',
                checked: false,
            };
            $scope.assignments.unshift($scope.newAssignmentObj);
        };

        $scope.saveAssignment = function() {
            console.log($scope.newAssignmentObj.due);
            $scope.newAssignmentObj.due = $('#datetimepicker0 input').val();
            $http.post('/api/v1/assignments',$scope.newAssignmentObj).
                success(function(data,success) {
                    $scope.newAssignmentObj = false;
                });
        };

        $scope.discardAssignment = function() {
            $scope.assignments.splice(0,1);
            $scope.newAssignmentObj = false;
        };
    }
]);

appCtrl.controller('ClassAssignmentCtrl',['$scope','$http','$routeParams',
    function ($scope,$http,$routeParams) {
        console.log("ClassAssignmentCtrl");
        $scope.assignments = [];
        $scope.newAssignmentObj = false;
        $scope.editing = false;

        var id = $routeParams.id;
        $scope.id = id;

        $http.get('/api/v1/classes/'+id).
            success(function(data,success) {
                $scope.class_ = data;
            });

        $http.get('/api/v1/classes/'+id+'/assignments').
            success(function(data,success) {
                angular.forEach(data,function(val,key) {
                    $scope.assignments.unshift(val);
                    $('#datetimepicker'+data.id+' input').val(val.due);
                });
            });

        $scope.rmAssignments = function() {
            angular.forEach($scope.assignments,function(val,key) {
                if (val.checked) {
                    $http.delete('/api/v1/assignments/'+val.id).
                        success(function(data,success) {
                            $scope.assignments.splice(key,1);
                        });
                }
            });
        };

        $scope.newAssignment = function() {
            $scope.newAssignmentObj = {
                class_id: $scope.id,
                id: 0,
                name: '',
                due: '',
                checked: false,
            };
            $scope.assignments.unshift($scope.newAssignmentObj);
        };

        $scope.saveAssignment = function() {
            console.log($scope.newAssignmentObj.due);
            $scope.newAssignmentObj.due = $('#datetimepicker0 input').val();
            $http.post('/api/v1/assignments',$scope.newAssignmentObj).
                success(function(data,success) {
                    $scope.newAssignmentObj = false;
                });
        };

        $scope.discard = function() {
            $scope.newAssignmentObj = false;
        };
    }
]);

appCtrl.controller('AssignmentCtrl',['$scope','$http','$routeParams',
    function($scope,$http,$routeParams) {
        console.log("AssignmentCtrl");
        $scope.assignment = {};
        var id = $routeParams.id;

        $scope.getRoster = function() {
            $http.get('/api/v1/assignments/'+$scope.assignment.id+'/students').
                success(function(data,success) {
                    $scope.roster = data;
                });
        };

        $scope.getAssignment = function() {
            $http.get('/api/v1/assignments/'+id).
                success(function(data,success) {
                    $scope.assignment = data;
                    $scope.getRoster();
                });
        };

        $scope.getAssignment();

        $scope.assign = function() {
            var id = $routeParams.id;
            $http.post('/api/v1/assignments/'+id+'/assign').
                success(function(data,success) {
                    $scope.getAssignment();
                });
        };
    }
]);

appCtrl.controller('StudentAssignmentCtrl',['$scope',
    function($scope) {
        console.log('StudentAssignmentCtrl');
    }
]);

appCtrl.controller('LoginCtrl', ['$scope','$http', '$location',
    function($scope,$http,$location) {
        console.log('LoginCtrl');
        $scope.data = {
            username: '',
            password: ''
        };
        $scope.login = function() {
            $http.post('/login', $scope.data).
                success(function(data) {
                    $location.path('/');
                });
        };
    }
]);

appCtrl.controller('AccountCtrl', ['$scope','$http',
    function($scope,$http) {
        console.log('AccountCtrl');
        $scope.account = {};
        $http.get('/app/userinfo').
            success(function(data,success) {
                $scope.account = data;
            });

        $scope.saveAccount = function() {
            $http.put('/app/account',$scope.account).
                success(function(data,success) {
                    $scope.account = data;
                });
        };
    }
]);
