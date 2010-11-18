<?php

class RoundRobinException extends Exception{}

class RoundRobin {

    private static $instance;
    private $storage;
        
    private function __construct() {
        $this->storage = MemoryCache::getGlobal();
    }

    public static function get(IRoundRobin $object) {
        return self::getInstance()->init($object);
    }

    private function init(IRoundRobin $object) {
        $id = $object->getRRId();
        $sizeList = $object->getRRSize();
                
        $counter = $this->storage->increment("round.robin.$id.counter");
        if (empty($counter)) {
            $this->storage->add("round.robin.$id.counter", 0);
            $counter = $this->storage->increment("round.robin.$id.counter");
        }
        if (empty($counter))
            throw new RoundRobinException('Can not increase counter');
        
        return $object->getRRElement(floor($counter % $sizeList));
    }

    private function getInstance() {
        if (!self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }
}
