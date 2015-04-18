<?php

class ControllerInformationFaq extends Controller
{
	public $error;
    public function index()
    {
        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/faq.css');

        $this->language->load('information/faq');

        $this->load->model('module/faq');

        $this->load->model('setting/setting');

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home'),
            'separator' => false
        );

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
		if(!empty($this->session->data['success'])){
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}
        $settings = $this->model_setting_setting->getSetting('faq');

        $limit = $settings['faq_pagination_val'];

        $start = $page * $limit - $limit;

        $faq_data = $this->model_module_faq->getFaq($start, $limit);

        $this->document->setTitle($this->language->get('heading_title'));

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('information/faq'),
            'text' => $this->language->get('heading_title'),
            'separator' => $this->language->get('text_separator'));

        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_more'] = $this->language->get('text_more');
		$this->data['text_add_link'] = $this->language->get('button_add');
        $this->data['text_posted'] = $this->language->get('text_posted');
		$this->data['text_answer'] = $this->language->get('text_answer');
        $this->data['text_no_results'] = $this->language->get('text_no_results');

        $this->load->model('tool/image');

        foreach ($faq_data as $result) {

            if (!empty($result['image'])) {
                $thumb = $this->model_tool_image->resize($result['image'], $this->config->get('faq_popup_width'), $this->config->get('faq_popup_height'));
            } else {
                $thumb = false;
            }

            $this->data['faq_data'][] = array(
                'id' => $result['faq_id'],
                'title' => $result['title'],
				'user_name' => $result['user_name'],
                'description' => html_entity_decode($result['description']),
				'answerer_name' => html_entity_decode($result['answerer_name']),
				'answer' => html_entity_decode($result['answer']),
                'href' => $this->url->link('information/faq/info', 'faq_id=' . $result['faq_id']),
                'posted' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
				);
        }

        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['continue'] = $this->url->link('common/home');

        $pagination = new Pagination();

        $pagination->total = $this->model_module_faq->getTotalFaq();
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('information/faq', '&page={page}');
		//$pagination->url = $this->url->link('faq.html', '&page={page}');

        $this->data['pagination'] = $pagination->render();
		
		if (true) { //(!$this->user->hasPermission('modify', 'module/faq'))
			$this->data['add_link'] = $this->url->link('information/faq/add', '');
		}

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/faq_list.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/information/faq_list.tpl';
        } else {
            $this->template = 'default/template/information/faq_list.tpl';
        }

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header');

        $this->response->setOutput($this->render());

    }

    public function info()
    {
        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/faq.css');

        $this->language->load('information/faq');
        $this->load->model('module/faq');
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home'),
            'separator' => false
        );
		if(!empty($this->session->data['success'])){
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}
        if (isset($this->request->get['faq_id'])) {
            $faq_id = $this->request->get['faq_id'];
        } else {
            $faq_id = 0;
        }

        $faq_info = $this->model_module_faq->getFaqStory($faq_id);

        if (!empty($faq_info)) {

            $this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
            $this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');

            $this->data['breadcrumbs'][] = array(
                'href' => $this->url->link('information/faq'),
                'text' => $this->language->get('heading_title'),
                'separator' => $this->language->get('text_separator')
            );

            $this->data['breadcrumbs'][] = array(
                'href' => $this->url->link('information/faq', 'faq_id=' . $this->request->get['faq_id']),
                'text' => $faq_info['title'],
                'separator' => $this->language->get('text_separator')
            );

            $this->document->setTitle($faq_info['title']);
            $this->document->setDescription($faq_info['meta_description']);
            $this->document->setKeywords($faq_info['meta_keywords']);
            $this->document->addLink($this->url->link('information/faq/info', 'faq_id=' . $this->request->get['faq_id']), 'canonical');

            $this->data['faq_info'] = $faq_info;

            $this->data['heading_title'] = $faq_info['title'];
			$this->data['user_name'] = html_entity_decode($faq_info['user_name']);
            $this->data['description'] = html_entity_decode($faq_info['description']);
			$this->data['answerer_name'] = html_entity_decode($faq_info['answerer_name']);
			$this->data['answer'] = html_entity_decode($faq_info['answer']);
            $this->data['date'] = date('d.m.Y', strtotime($faq_info['date_added']));

            $this->data['viewed'] = sprintf($this->language->get('text_viewed'), $faq_info['viewed']);

            $this->data['addthis'] = $this->config->get('faq_faqpage_addthis');

            /*$this->data['min_height'] = $this->config->get('faq_thumb_height');

            $this->load->model('tool/image');

            if ($faq_info['image']) {
                $this->data['image'] = true;
            } else {
                $this->data['image'] = false;
            }

            $this->data['thumb'] = $this->model_tool_image->resize($faq_info['image'], $this->config->get('faq_popup_width'), $this->config->get('faq_popup_height'));
            $this->data['popup'] = HTTP_SERVER . 'image/' . $faq_info['image'];*/

            $this->data['button_faq'] = $this->language->get('button_faq');
            $this->data['button_continue'] = $this->language->get('button_continue');

            //$this->data['faq'] = $this->url->link('information/faq');
			$this->data['faq'] = '/faq.html';
            $this->data['continue'] = $this->url->link('common/home');

            $this->model_module_faq->updateViewed($this->request->get['faq_id']);

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/faq.tpl')) {
                $this->template = $this->config->get('config_template') . '/template/information/faq.tpl';
            } else {
                $this->template = 'default/template/information/faq.tpl';
            }

            $this->children = array(
                'common/column_left',
                'common/column_right',
                'common/content_top',
                'common/content_bottom',
                'common/footer',
                'common/header');

            $this->response->setOutput($this->render());

        } else {
            $this->redirect($this->url->link('error/not_found'));

        }
    }
	
	public function add()
    {
        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/faq.css');
		$this->data['language'] = array('language_id' => $this->config->get('config_language_id'));//'1');
		$this->data['faq_store'] = $this->config->get('config_store_id');//'0';
        $this->language->load('information/faq');
        $this->load->model('module/faq');
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home'),
            'separator' => false
        );
		
		$this->data['heading_title'] = strip_tags($this->language->get('heading_title'));

        $this->document->setTitle($this->data['heading_title']);

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) {
			$data = $this->request->post;
			$data['status'] = 0;
			$data['pdate'] = time();
            $this->model_module_faq->addFaq($data);

            $this->session->data['success'] = $this->language->get('text_success');
			
			/**/
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			$mail->setTo($this->config->get('config_email'));
	  		$mail->setFrom($this->config->get('config_email'));//'helenlazar@yandex.ru'$this->request->post['email']
	  		$mail->setSender($this->config->get('config_name'));//($this->request->post['user_name']);
	  		$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['user_name'], $_SERVER['HTTP_HOST']), ENT_QUOTES, 'UTF-8'));
	  		$mail->setText(strip_tags(html_entity_decode(sprintf($this->language->get('email_text_prefix'),$this->request->post['user_name']).$this->request->post['faq_description'][$this->data['language']['language_id']]['description'], ENT_QUOTES, 'UTF-8')));
      		$mail->send();
			

            $this->redirect($this->url->link('information/faq', ''));
        }
		if(!empty($this->request->post['faq_description'])){
			$this->data['faq_description'] = $this->request->post['faq_description'];
		}
		if(!empty($this->request->post['user_name'])){
			$this->data['user_name'] = $this->request->post['user_name'];
		}

        $this->data['entry_title'] = $this->language->get('entry_title');
        //$this->data['entry_name'] = $this->language->get('entry_name');
        //$this->data['entry_pdate'] = $this->language->get('entry_pdate');
		$this->data['entry_user_name'] = $this->language->get('entry_user_name');
        $this->data['entry_description'] = $this->language->get('entry_description');
        //$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');
        //$this->data['entry_status'] = $this->language->get('entry_status');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
		
		if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['title'])) {
            $this->data['error_title'] = $this->error['title'];
        } else {
            $this->data['error_title'] = '';
        }

        if (isset($this->error['name'])) {
            $this->data['error_name'] = $this->error['name'];
        } else {
            $this->data['error_name'] = '';
        }
		
		if (isset($this->error['user_name'])) {
            $this->data['error_user_name'] = $this->error['user_name'];
        } else {
            $this->data['error_user_name'] = '';
        }

        if (isset($this->error['description'])) {
            $this->data['error_description'] = $this->error['description'];
        } else {
            $this->data['error_description'] = '';
        }
		if (isset($this->error['captcha'])) {
            $this->data['error_captcha'] = $this->error['captcha'];
        } else {
            $this->data['error_captcha'] = '';
        }
		$this->data['action'] = $this->url->link('information/faq/add', '');
		$this->data['cancel'] = $this->url->link('information/faq', '');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/faq/form.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/faq/form.tpl';
		} else {
			$this->template = 'default/template/information/faq/form.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header');

		$this->response->setOutput($this->render());
    }
	
	private function validateForm()
    {
		$error = array();
        /*if (!$this->user->hasPermission('modify', 'module/faq')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }*/

		$language_id = $this->data['language']['language_id'];
		if ((strlen($this->request->post['user_name']) < 3) || (strlen($this->request->post['user_name']) > 250)) {
			$error['user_name'] = $this->language->get('error_user_name');
			//self::$error['user_name'] = $this->language->get('error_user_name');
		}
		
		if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
      		$error['captcha'] = $this->language->get('error_captcha');
    	}
		
        foreach ($this->request->post['faq_description'] as $language_id => $value) {
            if ((strlen($value['title']) < 3) || (strlen($value['title']) > 250)) {
                $error['title'][$language_id] = $this->language->get('error_title');
            }

            if ((strlen($value['description']) < 3)||(strlen($value['description']) > 2000)) {
                $error['description'][$language_id] = $this->language->get('error_description');
            }
        }
		$this->error = $error;
        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
	
	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}

}

?>
