<?php

class Charge extends Model
{
	private $id;
	private $name;
	
	static $has_many = array(
		array('user_charges'),
		array('users', 'trhough' => 'user_charges')
	);

	static $validates_uniqueness_of = array(
		array('name', 'message' => 'Cargo já cadastrado.')
	);

	static $validates_presence_of = array(
		array('name', 'message' => 'já existe.')
	);

	static $validates_size_of = array(
		// array('name', 'within' => array(3, 25), 'too_short' => 'muito curto.', 'too_long' => 'muito grande.')
	);

	public function users()
	{
		return $this->users;
	}

	public function user_charges()
	{
		return $this->user_charges;
	}

	public function before_destroy()
	{
		$options = array(
            'conditions' => array(
                'charge_id' => $this->id)
        );

		UserCharge::delete_all($options);
	}
}