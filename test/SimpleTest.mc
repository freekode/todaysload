class SimpleTest {

	(:test)
    function myUnitTest(logger) {
        var x = 2 + 2;
        logger.debug("x = " + x);
        return (x == 4); // returning true indicates pass, false indicates failure
    }
}
