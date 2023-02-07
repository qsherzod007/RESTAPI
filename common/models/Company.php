<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "company".
 *
 * @property int $id
 * @property string $company_name
 * @property string|null $director_name
 * @property string|null $address
 * @property string $email
 * @property string $website
 * @property string $phone_number
 *
 * @property Employee[] $employees
 */
class Company extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'company';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['company_name', 'director_name', 'address'], 'string', 'max' => 100],
            [['email', 'website', 'phone_number'], 'string', 'max' => 50],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'company_name' => 'Company Name',
            'director_name' => 'Director Name',
            'address' => 'Address',
            'email' => 'Email',
            'website' => 'Website',
            'phone_number' => 'Phone Number',
        ];
    }

    /**
     * Gets query for [[Employees]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getEmployees()
    {
        return $this->hasMany(Employee::class, ['company_id' => 'id']);
    }
}
