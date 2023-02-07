<?php

namespace api\controllers;

use api\models\Employee;
use common\models\User;
use common\models\Company;
use yii\data\ActiveDataProvider;
use yii\helpers\Url;
use yii\web\ServerErrorHttpException;

class CompanyController extends MyController
{
    public function actionIndex()
    {
        $user = \Yii::$app->user->identity;
        if ($user->role === User::ROLE_ADMIN) {
            $dataProvider = new ActiveDataProvider([
                'query' => Company::find(),
            ]);
        } elseif ($user->role === User::ROLE_COMPANY) {
            $dataProvider = new ActiveDataProvider([
                'query' => Company::find()->where(['id' => $user->company_id]),
            ]);
        }
        return $dataProvider;
    }

    public function actionView($id)
    {
        $user = \Yii::$app->user->identity;
        if ($user->role === User::ROLE_ADMIN) {
            $model = Company::findOne($id);
            return $model;
        } elseif ($user->role === User::ROLE_COMPANY) {
            $model = Company::findOne($id);
            if ($user->company_id != $model->id) {
                return [
                    'xato' => 'Adminga murojaat qiling',
                    'message' => 'Bu kompaniya ma`lumotlarini ko`ra olmaysiz'
                ];
            }
            return $model;
        }
    }

    public function actionCreate()
    {
        $user = \Yii::$app->user->identity;
        $model = new Company();
        if ($user->role != User::ROLE_ADMIN) {
            return [
                'xato' => 'Adminga murojaat qiling',
                'message' => 'Siz yangi kompaniya yarata olmaysiz'
            ];
        }
        $post = \Yii::$app->request->getBodyParams();
        if ($post) {
            if ($model->load($post, '') && $model->save()) {
                return $model;
            } elseif (!$model->hasErrors()) {
                throw new ServerErrorHttpException('Failed to create the object for unknown reason.');
            }
        }
    }

    public function actionUpdate($id)
    {
        $user = \Yii::$app->user->identity;
        $post = \Yii::$app->request->getBodyParams();
        if ($user->role === User::ROLE_ADMIN){
            $model = Company::findOne($id);
            if ($post) {
                if ($model->load($post, '') && $model->save()) {
                    return $model;
                }
            }
        }elseif ($user->role === User::ROLE_COMPANY) {
            $model = Company::findOne($id);
            if ($user->company_id == $model->id) {
                if ($post) {
                    if ($model->load($post, '') && $model->save()) {
                        return $model;
                    }
                }
            }
            return [
                'xato' => 'Adminga murojaat qiling',
                'message' => 'Siz bu kompaniya ma`lumotlarini o`zgartira olmaysiz'
            ];
        }
    }

    public function actionDelete($id)
    {
        $user = \Yii::$app->user->identity;
        if ($user->role === User::ROLE_ADMIN) {
            $model = Company::findOne($id);
            if ($model->delete()) {
                return $model;
            }
        } elseif ($user->role === User::ROLE_COMPANY) {
            return [
                'xato' => 'Adminga murojaat qiling',
                'message' => 'Siz kompaniya ma`lumotlarini o`chira olmaysiz'
            ];
        }
    }

}