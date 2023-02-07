<?php

namespace api\controllers;


use api\models\LoginForm;
use yii\rest\Controller;

/**
 * Site controller
 */
class SiteController extends Controller
{
    public function actionLogin()
    {
        $model = new LoginForm();
        if ($model->load(\Yii::$app->request->post(), '') && ($token = $model->login())){
            return ['token' => $token];
        }else{
            return $model;
        }
    }
}
