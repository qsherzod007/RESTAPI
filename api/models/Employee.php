<?php

namespace api\models;

class Employee extends \common\models\Employee
{
        public function fields()
        {
            return [
                'id',
                'company' => function($model){
                    return $model->company->company_name;
                },
                'passport_No',
                'first_name',
                'last_name',
                'middle_name',
                'position',
                'phone_number',
                'address',
            ];
        }
}