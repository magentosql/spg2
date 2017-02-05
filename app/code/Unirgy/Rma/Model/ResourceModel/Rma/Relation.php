<?php
/**
 * Copyright © 2015 Magento. All rights reserved.
 * See COPYING.txt for license details.
 */

namespace Unirgy\Rma\Model\ResourceModel\Rma;

use Magento\Framework\Model\ResourceModel\Db\VersionControl\RelationInterface;
use Unirgy\Rma\Model\ResourceModel\Rma\Item as UrmaItemResource;
use Unirgy\Rma\Model\ResourceModel\Rma\Comment as UrmaCommentResource;
use Unirgy\Rma\Model\ResourceModel\Rma\Track as UrmaTrackResource;

/**
 * Class Relation
 */
class Relation implements RelationInterface
{
    /**
     * @var urmaItemResource
     */
    protected $urmaItemResource;

    /**
     * @var urmaTrackResource
     */
    protected $urmaTrackResource;

    /**
     * @var urmaCommentResource
     */
    protected $urmaCommentResource;

    /**
     * @param Item $urmaItemResource
     * @param Track $urmaTrackResource
     * @param Comment $urmaCommentResource
     */
    public function __construct(
        UrmaItemResource $urmaItemResource,
        UrmaTrackResource $urmaTrackResource,
        UrmaCommentResource $urmaCommentResource
    ) {
        $this->urmaItemResource = $urmaItemResource;
        $this->urmaTrackResource = $urmaTrackResource;
        $this->urmaCommentResource = $urmaCommentResource;
    }

    /**
     * Process relations for urma
     *
     * @param \Magento\Framework\Model\AbstractModel $object
     * @return void
     * @throws \Exception
     */
    public function processRelation(\Magento\Framework\Model\AbstractModel $object)
    {
        /** @var \Magento\Sales\Model\Order\urma $object */
        if (null !== $object->getItems()) {
            foreach ($object->getItems() as $item) {
                $item->setParentId($object->getId());
                $this->urmaItemResource->save($item);
            }
        }
        if (null !== $object->getTracks()) {
            foreach ($object->getTracks() as $track) {
                $this->urmaTrackResource->save($track);
            }
        }
        if (null !== $object->getComments()) {
            foreach ($object->getComments() as $comment) {
                $this->urmaCommentResource->save($comment);
            }
        }
    }
}
