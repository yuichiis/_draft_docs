<?php

class ACL
{
    public static function assert(array $params, array $args) : bool
    {
        echo "[assert]\n";
        echo "[params:";
        var_dump($params);
        echo "]\n";
        echo "[args:";
        var_dump($args);
        echo "]\n";
        return true;
    }
}

class Interceptor
{
    protected object $instance;
    protected ReflectionClass $classRef;

    public function __construct(object $instance)
    {
        $this->instance = $instance;
        $this->classRef = new ReflectionClass($instance);
    }

    public function __call(string $method, array $args)
    {
        $funcRef = $this->classRef->getMethod($method);
        $acls = $funcRef->getAttributes(ACL::class);
        if(count($acls) > 0) {
            foreach($acls as $acl) {
                $params = $acl->getArguments();
                if(!ACL::assert($params,$args)) {
                    throw new AccessException("Access Denied");
                }
            }
        }
        return $this->instance->$method(...$args);
    }
}

class Controller
{
    #[ACL("check")]
    #[ACL("owner")]
    public function action(string $action) : mixed
    {
        return "result";
    }
}

$controller = new Interceptor(new Controller());

$result = $controller->action("abc");

echo "result:";
echo var_dump($result);
