<?php echo $header; ?>
<?php echo $content_top; ?>
<?php echo $column_left; ?>
    <div id="content">
        <?php echo $column_right; ?>
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <?php echo $breadcrumb['separator']; ?><a
                href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
        </div>
		<?php if(!empty($success)){
			?>
			<div class = "message"><?php echo $success; ?></div>
			<?php
		}
		?>
        <h1><?php echo $heading_title; ?></h1>

        <div class="">
            <?php if (isset($faq_data)) { ?>
                <?php foreach ($faq_data as $faq) { ?>
                    <div class="faq">
                        <div class="faq_title">
							<a href="<?php echo $faq['href']; ?>"><?php echo $faq['title']; ?></a>
                        </div>
                        <strong class="faq-date"><?php echo $faq['posted']; ?></strong>

                        <div class="panelcontent">
							<div class="faq_user_name">
                            <?php echo $faq['user_name']; ?>
							</div>
							<div class="faq_question">
                            <?php echo $faq['description']; ?>
							</div>
							<div class="faq_answerer_name">
							<?php echo $faq['answerer_name']; ?>
							</div>
							<div class="faq_answer">
							<?php echo $faq['answer']; ?>
							</div>
                            <div class="btn-block">
                                <a class="button" href="<?php echo $faq['href']; ?>"> <?php echo $text_more; ?></a>
                            </div>
                        </div>
                    </div>
                <?php } ?>
                <div class="pagination"><?php echo $pagination; ?></div>
            <?php } else { ?>
                <p><?php echo $text_no_results; ?></p>
            <?php } ?>
			<?php if(!empty($add_link)){?>
			<div class="btn-block">
				<a class="button" href="<?php echo $add_link; ?>"> <?php echo $text_add_link; ?></a>
			</div>
			<?php } ?>
        </div>
    </div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>