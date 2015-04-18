<?php
if(!empty($success)){
	?>
	<div class = "message"><?php echo $success; ?></div>
	<?php
}
if ($faq) { ?>
    <div class="box">
        <?php if ($header) { ?>
        <div class="box-heading">
            <span class="icon-faq"><?php echo $customtitle; ?></span>
        </div>
        <?php } ?>
        <div class="box-content">
            <div class="box-faq">
                <?php foreach ($faq as $faq_story) { ?>
                    <div class="faq-item">
                        <?php if ($show_headline) { ?>
                            <div class="faq-title">
                                <a href="<?php echo $faq_story['href']; ?>"><?php echo $faq_story['title']; ?></a>
                            </div>
                        <?php } ?>
                        <div class="faq-date"><?php echo $faq_story['posted']; ?></div>
                        <div class="faq-desc">
							<div class="faq_user_name">
                            <?php echo $faq_story['user_name']; ?>
							</div>
							<div class="faq_question">
                            <?php echo $faq_story['description']; ?>
							</div>
							<div class="faq_answerer_name">
							<?php echo $faq_story['answerer_name']; ?>
							</div>
							<div class="faq_answer">
							<?php echo $faq_story['answer']; ?>
							</div>
                        </div>
						<div class="btn-block">
							<a class="button" href="<?php echo $faq_story['href']; ?>"> <?php echo $text_more; ?></a>
						</div>
                    </div>
                <?php } ?>
                <!-- <div class="faq-buttons">
                    <a href="<?php echo $faqlist;?>" class="button">
                        <?php echo $buttonlist; ?>
                    </a>
                </div> -->
				<div class="pagination"><?php echo $pagination; ?></div>
				<?php if(!empty($add_link)){?>
				<div class="btn-block">
					<a class="button" href="<?php echo $add_link; ?>"> <?php echo $text_add_link; ?></a>
				</div>
				<?php } ?>
            </div>
        </div>
    </div>
<?php } ?>