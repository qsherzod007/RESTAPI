<?php

namespace api\controllers;

use api\models\Employee;
use common\models\Company;
use common\models\User;
use yii\data\ActiveDataProvider;
use yii\web\ServerErrorHttpException;

class EmployeeController extends MyController
{
    public function actionIndex()
    {
        $user = \Yii::$app->user->identity;
        if ($user->role === User::ROLE_ADMIN) {
            $dataProvider = new ActiveDataProvider([
                'query' => Employee::find(),
            ]);
        } elseif ($user->role === User::ROLE_COMPANY) {
            $dataProvider = new ActiveDataProvider([
                'query' => Employee::find()->where(['company_id' => $user->company_id]),
            ]);
        }
        return $dataProvider;
    }

    public function actionView($id)
    {
        $user = \Yii::$app->user->identity;
        if ($user->role === User::ROLE_ADMIN) {
            $model = Employee::findOne($id);
            return $model;
        } elseif ($user->role === User::ROLE_COMPANY) {
            $model = Employee::findOne($id);
            if ($user->company_id != $model->company_id) {
                return [
                    'xato' => 'Adminga murojaat qiling',
                    'message' => 'Bu xodim ma`lumotlarini ko`ra olmaysiz'
                ];
            }
            return $model;
        }
    }

    public function actionCreate()
    {
        $user = \Yii::$app->user->identity;
        $model = new Employee();
        $post = \Yii::$app->request->getBodyParams();
        if ($user->role === User::ROLE_ADMIN) {
            if ($model->load($post, '') && $model->save()) {
                return $model;
            }
        } elseif ($user->role === User::ROLE_COMPANY) {
            if ($post) {
                if ($model->load($post, '') && $model->company_id == $user->company_id) {
                    if ($model->save()) {
                        return $model;
                    }
                } else {
                    return [
                        'xato' => 'Adminga murojaat qiling',
                        'message' => 'Bu companiyaga xodim qo`sha olmaysiz'
                    ];
                }
            }
        }
    }

    public function actionUpdate($id)
    {
        $user = \Yii::$app->user->identity;
        $post = \Yii::$app->request->getBodyParams();
        if ($user->role === User::ROLE_ADMIN) {
            $model = Employee::findOne($id);
            if ($post) {
                if ($model->load($post, '') && $model->save()) {
                    return $model;
                }
            }
        } elseif ($user->role === User::ROLE_COMPANY) {
            $model = Employee::findOne($id);
            if ($user->company_id == $model->company_id) {
                if ($post) {
                    if ($model->load($post, '') && $model->save()) {
                        return $model;
                    }
                }
            }
            return [
                'xato' => 'Adminga murojaat qiling',
                'message' => 'Siz bu xodim ma`lumotlarini o`zgartira olmaysiz'
            ];
        }
    }

    public function actionDelete($id)
    {
        $user = \Yii::$app->user->identity;
        if ($user->role === User::ROLE_ADMIN) {
            $model = Employee::findOne($id);
            if ($model->delete()) {
                return $model;
            }
        } elseif ($user->role === User::ROLE_COMPANY) {
            $model = Employee::findOne($id);
            if ($user->company_id == $model->company_id) {
                if ($model->delete()) {
                    return $model;
                }
            }
            return [
                'xato' => 'Adminga murojaat qiling',
                'message' => 'Siz bu xodim ma`lumotlarini o`chira olmaysiz'
            ];
        }
    }
}