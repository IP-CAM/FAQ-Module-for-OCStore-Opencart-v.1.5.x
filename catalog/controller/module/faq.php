<?php
//-----------------------------------------------------
// Faq Module for Opencart v1.5.5   							
// Modified by morrah      
// http://mocca-web.ru                    			
// webdepo@list.ru                                   			
//-----------------------------------------------------

class ControllerModuleFaq extends Controller {

	protected function index($setting) {
		static $module = 0;
	
		$this->language->load('module/faq');
	
      	$this->data['heading_title'] = $this->language->get('heading_title');
	
		$this->data['customtitle'] = $this->config->get('faq_customtitle' . $this->config->get('config_language_id'));

		$this->data['header'] = $this->config->get('faq_header');

		if (!$this->data['customtitle']) { $this->data['customtitle'] = $this->data['heading_title']; } 

		$this->data['icon'] = $this->config->get('faq_icon');

		$this->data['box'] = $this->config->get('faq_box');

		$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/faq.css');
	
		$this->load->model('module/faq');
	
		$this->data['text_more'] = $this->language->get('text_more');

		$this->data['text_posted'] = $this->language->get('text_posted');
		
		$this->data['text_add_link'] = $this->language->get('button_add');

		$this->data['text_answer'] = $this->language->get('text_answer');
	
		$this->data['show_headline'] = $this->config->get('faq_headline_module');
	
		$this->data['faq_count'] = $this->model_module_faq->getTotalFaq();
		
		$this->data['faq_limit'] = $setting['limit'];
	
		if ($this->data['faq_count'] > $this->data['faq_limit']) { $this->data['showbutton'] = true; } else { $this->data['showbutton'] = false; }
	
		$this->data['buttonlist'] = $this->language->get('buttonlist');
	
		$this->data['faqlist'] = $this->url->link('information/faq');
		
		$this->data['numchars'] = $setting['numchars'];
		
		if (isset($this->data['numchars'])) { $chars = $this->data['numchars']; } else { $chars = 100; }
		if(!empty($this->session->data['success'])){
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}
		$this->data['faq'] = array();
		
		
		if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
		//$settings = $this->model_setting_setting->getSetting('faq');

        //$limit = $settings['faq_pagination_val'];
		
		$limit = $setting['limit'];

        $start = $page * $limit - $limit;
		
		$results = $this->model_module_faq->getFaq($start, $limit);

		//$results = $this->model_module_faq->getFaqShorts($setting['limit']);

        //$this->load->model('tool/image');
	
		foreach ($results as $result) {
            /*if (!empty($result['image'])) {
                $thumb = $this->model_tool_image->resize($result['image'], $this->config->get('faq_thumb_width'), $this->config->get('faq_thumb_height'));
            } else {
                $thumb = false;
            }*/

			$this->data['faq'][] = array(
				'title'        		=> $result['title'],
				'description'  	=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $chars).'...',
				'user_name' => $result['user_name'],
                'answerer_name'       => html_entity_decode($result['answerer_name']),
				'answer' => html_entity_decode($result['answer']),
				'href'         		=> $this->url->link('information/faq/info', 'faq_id=' . $result['faq_id']),
				'posted'   		=> date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

        $this->data['faq_limit'] = $this->config->get('faq_module_limit');
	
		$this->data['module'] = $module++; 
		
		$pagination = new Pagination();

        $pagination->total = $this->model_module_faq->getTotalFaq();
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->text = $this->language->get('text_pagination');
        //$pagination->url = $this->url->link('information/faq', '&page={page}');
		$pagination->url = 'faq.html?page={page}';

        $this->data['pagination'] = $pagination->render();
		
		if (true) { //(!$this->user->hasPermission('modify', 'module/faq'))
			$this->data['add_link'] = $this->url->link('information/faq/add', '');
		}
	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . 'faq.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/' . 'faq.tpl';
		} else {
			$this->template = 'default/template/module/' . 'faq.tpl';
		}
	
		$this->render();
	}
}
?>
