<?php
//-----------------------------------------------------
// Faq Module for Opencart v1.5.5   							
// Modified by morrah      
// http://mocca-web.ru                    			
// webdepo@list.ru                          			
//-----------------------------------------------------

class ModelModuleFaq extends Model {

	public function updateViewed($faq_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "faq SET viewed = (viewed + 1) WHERE faq_id = '" . (int)$faq_id . "'");
	}

	public function getFaqStory($faq_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "faq n LEFT JOIN " . DB_PREFIX . "faq_description nd ON (n.faq_id = nd.faq_id) LEFT JOIN " . DB_PREFIX . "faq_to_store n2s ON (n.faq_id = n2s.faq_id) WHERE n.faq_id = '" . (int)$faq_id . "' AND nd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND n.status = '1'");
	
		return $query->row;
	}

    public function getFaq($start,$limit) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "faq n LEFT JOIN " . DB_PREFIX . "faq_description nd ON (n.faq_id = nd.faq_id) LEFT JOIN " . DB_PREFIX . "faq_to_store n2s ON (n.faq_id = n2s.faq_id) WHERE nd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND n.status = '1' ORDER BY n.date_added DESC LIMIT $start, $limit ");

		return $query->rows;
	}

	public function getFaqShorts($limit) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "faq n LEFT JOIN " . DB_PREFIX . "faq_description nd ON (n.faq_id = nd.faq_id) LEFT JOIN " . DB_PREFIX . "faq_to_store n2s ON (n.faq_id = n2s.faq_id) WHERE nd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND n.status = '1' ORDER BY n.date_added DESC LIMIT " . (int)$limit); 
	   
       
		return $query->rows;
	}

	public function getTotalFaq() {
     	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "faq n LEFT JOIN " . DB_PREFIX . "faq_to_store n2s ON (n.faq_id = n2s.faq_id) WHERE n2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND n.status = '1'");
	
		if ($query->row) {
			return $query->row['total'];
		} else {
			return FALSE;
		}
	}

	public function addFaq($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "faq SET status = '" . (int)$data['status'] . "', date_added = '".date('Y-m-d H:i:s', $data['pdate']).' '.date('H:i:s')."', user_name = '" .$data['user_name'] . "'");
	
		$faq_id = $this->db->getLastId();
	
		/*if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "faq SET image = '" . $this->db->escape($data['image']) . "' WHERE faq_id = '" . (int)$faq_id . "'");
		}*/
	
		foreach ($data['faq_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "faq_description SET
			faq_id = '" . (int)$faq_id . "',
			language_id = '" . (int)$language_id . "',
			title = '" . $this->db->escape($value['title']) . "',
			description = '" . $this->db->escape($value['description']) . "'");
		}
	
		if (isset($data['faq_store'])) {
			if(is_array($data['faq_store'])){
				foreach ($data['faq_store'] as $store_id) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "faq_to_store SET faq_id = '" . (int)$faq_id . "', store_id = '" . (int)$store_id . "'");
				}
			}
			else{
				$this->db->query("INSERT INTO " . DB_PREFIX . "faq_to_store SET faq_id = '" . (int)$faq_id . "', store_id = '" . (int)$data['faq_store'] . "'");
			}
		}
	
		$this->cache->delete('faq');
	}
}
?>
