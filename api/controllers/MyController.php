<?php

namespace api\controllers;

use yii\filters\auth\HttpBasicAuth;
use yii\rest\ActiveController;
use yii\rest\Controller;

class MyController extends Controller
{
        public function behaviors()
        {
            $behaviors = parent::behaviors();
            $behaviors['corsFilter'] = [
                'class' => \yii\filters\Cors::class,
            ];
            $behaviors['authenticator'] = [
                'class' => HttpBasicAuth::class,
            ];
            return $behaviors;
        }
}