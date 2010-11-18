<?php

/*
    The interface, that should be implemented by class to use in RoundRobin class
    @see RoundRobin
 */
interface IRoundRobin {
    /*
        Unique identifier of the round robin list
     */
    public function getRRId();
    /**
        size of round robin list
     */
    public function getRRSize();

    /**
        Element that will be used as round robin. Index starts from 0
     */
    public function getRRElement($index);
}
