<?php

namespace Unirgy\Rma\Model\Label;

use Unirgy\Dropship\Model\Label\Pdf as LabelPdf;

class Pdf extends LabelPdf
{
    public function getBatchFileName($batch)
    {
        $filename = 'label_batch-'.$batch->getId().'.pdf';
        if ($batch->getForcedFilename()) {
            $filename = $batch->getForcedFilename().'.pdf';
        }
        return $filename;
    }
}